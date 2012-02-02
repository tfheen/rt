# BEGIN BPS TAGGED BLOCK {{{
#
# COPYRIGHT:
#
# This software is Copyright (c) 1996-2012 Best Practical Solutions, LLC
#                                          <sales@bestpractical.com>
#
# (Except where explicitly superseded by other copyright notices)
#
#
# LICENSE:
#
# This work is made available to you under the terms of Version 2 of
# the GNU General Public License. A copy of that license should have
# been provided with this software, but in any event can be snarfed
# from www.gnu.org.
#
# This work is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301 or visit their web page on the internet at
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.html.
#
#
# CONTRIBUTION SUBMISSION POLICY:
#
# (The following paragraph is not intended to limit the rights granted
# to you to modify and distribute this software under the terms of
# the GNU General Public License and is only of importance to you if
# you choose to contribute your changes and enhancements to the
# community by submitting them to Best Practical Solutions, LLC.)
#
# By intentionally submitting any modifications, corrections or
# derivatives to this work, or any other work intended for use with
# Request Tracker, to Best Practical Solutions, LLC, you confirm that
# you are the copyright holder for those contributions and you grant
# Best Practical Solutions,  LLC a nonexclusive, worldwide, irrevocable,
# royalty-free, perpetual, license to use, copy, create derivative
# works based on those contributions, and sublicense and distribute
# those contributions and any derivatives thereof.
#
# END BPS TAGGED BLOCK }}}

package RT::Interface::Email::Auth::MailFrom;

use strict;
use warnings;

use RT::Interface::Email qw(ParseSenderAddressFromHead CreateUser);

# This is what the ordinary, non-enhanced gateway does at the moment.

sub GetCurrentUser {
    my %args = ( Message     => undef,
                 CurrentUser => undef,
                 AuthLevel   => undef,
                 Ticket      => undef,
                 Queue       => undef,
                 Action      => undef,
                 @_ );


    # We don't need to do any external lookups
    my $addresses = ParseSenderAddressFromHead( $args{'Message'}->head );
    unless ( $addresses ) {
        $RT::Logger->error("Couldn't find sender's address");
        return ( $args{'CurrentUser'}, -1 );
    }

    # If the user can't be loaded, we may need to create one. Figure out the acl situation.
    my $unpriv = RT->UnprivilegedUsers();
    unless ( $unpriv->Id ) {
        $RT::Logger->crit("Couldn't find the 'Unprivileged' internal group");
        return ( $args{'CurrentUser'}, -1 );
    }

    my $everyone = RT::Group->new( RT->SystemUser );
    $everyone->LoadSystemInternalGroup('Everyone');
    unless ( $everyone->Id ) {
        $RT::Logger->crit("Couldn't find the 'Everyone' internal group");
        return ( $args{'CurrentUser'}, -1 );
    }

    my ($right, $right_error) = WhichRightShouldBeChecked( %args );
    return ( $args{'CurrentUser'}, 0 ) unless $right;

    my $check_right = sub {
        if ( my $user = shift ) {
            return $user->PrincipalObj->HasRight(
                Object => $args{'Queue'}, Right => $right
            );
        }
        return
            $everyone->PrincipalObj->HasRight(
                Object => $args{'Queue'}, Right => $right
            ) || $unpriv->PrincipalObj->HasRight(
                Object => $args{'Queue'}, Right => $right,
            )
        ;
    };

    my $user;
    foreach my $addr ( @$addresses ) {
        $RT::Logger->debug("Testing $addr as sender");

        my $CurrentUser = RT::CurrentUser->new;
        $CurrentUser->LoadByEmail( $addr->address );
        $CurrentUser->LoadByName( $addr->address ) unless $CurrentUser->Id;
        if ( $CurrentUser->Id ) {
            $RT::Logger->debug("$addr belongs to user #". $CurrentUser->Id );
            return ( $CurrentUser, 1 ) if $check_right->( $CurrentUser );

            $user ||= $CurrentUser;
            $RT::Logger->debug( "User has $right_error. Skipping $addr" );
        }
        elsif ( $check_right->() ) {
            $RT::Logger->debug("Going to create user $addr" );
            $CurrentUser = CreateUser(
                undef, $addr->address, $addr->phrase, $addr->address,
                $args{'Message'}
            );
            return ( $CurrentUser, 1 );
        } else {
            $RT::Logger->debug( "Unprivileged users have $right_error. Skipping $addr" );
        }
    }
    $RT::Logger->debug("Sender(s) has no enough rights");
    return $user ? ($user, 1) : ($args{'CurrentUser'}, 0);
}

sub WhichRightShouldBeChecked {
    my %args = @_;

    my $qname = $args{'Queue'}->Name;

    if ( $args{'Ticket'} && $args{'Ticket'}->Id ) {
        # We have a ticket. that means we're commenting or corresponding
        if ( $args{'Action'} =~ /^comment$/i ) {
            return (
                'CommentOnTicket',
                "no right to comment on ticket in queue '$qname'",
            );
        }
        elsif ( $args{'Action'} =~ /^correspond$/i ) {
            return (
                'ReplyToTicket',
                "no right to reply to ticket in queue '$qname'",
            );
        }
        elsif ( $args{'Action'} =~ /^take$/i ) {
            return (
                'OwnTicket',
                "no right to own ticket in queue '$qname'",
            );
        }
        elsif ( $args{'Action'} =~ /^resolve$/i ) {
            return (
                'ModifyTicket',
                "no right to resolve ticket in queue '$qname'",
            );
        }
        else {
            $RT::Logger->warning("Action '". ($args{'Action'}||'') ."' is unknown");
            return;
        }
    }

    # We're creating a ticket
    elsif ( $args{'Queue'} && $args{'Queue'}->Id ) {
        # check to see whether "Everybody" or "Unprivileged users" can create tickets in this queue
        return (
            'CreateTicket',
            "no right to create ticket in queue '$qname'",
        );
    }
    return;
}

RT::Base->_ImportOverlays();

1;
