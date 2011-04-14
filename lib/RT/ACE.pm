# BEGIN BPS TAGGED BLOCK {{{
# 
# COPYRIGHT:
#  
# This software is Copyright (c) 1996-2011 Best Practical Solutions, LLC
#                                          <jesse@bestpractical.com>
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
# Autogenerated by DBIx::SearchBuilder factory (by <jesse@bestpractical.com>)
# WARNING: THIS FILE IS AUTOGENERATED. ALL CHANGES TO THIS FILE WILL BE LOST.  
# 
# !! DO NOT EDIT THIS FILE !!
#

use strict;


=head1 NAME

RT::ACE


=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

package RT::ACE;
use RT::Record; 


use vars qw( @ISA );
@ISA= qw( RT::Record );

sub _Init {
  my $self = shift; 

  $self->Table('ACL');
  $self->SUPER::_Init(@_);
}





=head2 Create PARAMHASH

Create takes a hash of values and creates a row in the database:

  varchar(25) 'PrincipalType'.
  int(11) 'PrincipalId'.
  varchar(25) 'RightName'.
  varchar(25) 'ObjectType'.
  int(11) 'ObjectId'.
  int(11) 'DelegatedBy'.
  int(11) 'DelegatedFrom'.

=cut




sub Create {
    my $self = shift;
    my %args = ( 
                PrincipalType => '',
                PrincipalId => '0',
                RightName => '',
                ObjectType => '',
                ObjectId => '0',
                DelegatedBy => '0',
                DelegatedFrom => '0',

		  @_);
    $self->SUPER::Create(
                         PrincipalType => $args{'PrincipalType'},
                         PrincipalId => $args{'PrincipalId'},
                         RightName => $args{'RightName'},
                         ObjectType => $args{'ObjectType'},
                         ObjectId => $args{'ObjectId'},
                         DelegatedBy => $args{'DelegatedBy'},
                         DelegatedFrom => $args{'DelegatedFrom'},
);

}



=head2 id

Returns the current value of id. 
(In the database, id is stored as int(11).)


=cut


=head2 PrincipalType

Returns the current value of PrincipalType. 
(In the database, PrincipalType is stored as varchar(25).)



=head2 SetPrincipalType VALUE


Set PrincipalType to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, PrincipalType will be stored as a varchar(25).)


=cut


=head2 PrincipalId

Returns the current value of PrincipalId. 
(In the database, PrincipalId is stored as int(11).)



=head2 SetPrincipalId VALUE


Set PrincipalId to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, PrincipalId will be stored as a int(11).)


=cut


=head2 RightName

Returns the current value of RightName. 
(In the database, RightName is stored as varchar(25).)



=head2 SetRightName VALUE


Set RightName to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, RightName will be stored as a varchar(25).)


=cut


=head2 ObjectType

Returns the current value of ObjectType. 
(In the database, ObjectType is stored as varchar(25).)



=head2 SetObjectType VALUE


Set ObjectType to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, ObjectType will be stored as a varchar(25).)


=cut


=head2 ObjectId

Returns the current value of ObjectId. 
(In the database, ObjectId is stored as int(11).)



=head2 SetObjectId VALUE


Set ObjectId to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, ObjectId will be stored as a int(11).)


=cut


=head2 DelegatedBy

Returns the current value of DelegatedBy. 
(In the database, DelegatedBy is stored as int(11).)



=head2 SetDelegatedBy VALUE


Set DelegatedBy to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, DelegatedBy will be stored as a int(11).)


=cut


=head2 DelegatedFrom

Returns the current value of DelegatedFrom. 
(In the database, DelegatedFrom is stored as int(11).)



=head2 SetDelegatedFrom VALUE


Set DelegatedFrom to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, DelegatedFrom will be stored as a int(11).)


=cut



sub _CoreAccessible {
    {
     
        id =>
		{read => 1, sql_type => 4, length => 11,  is_blob => 0,  is_numeric => 1,  type => 'int(11)', default => ''},
        PrincipalType => 
		{read => 1, write => 1, sql_type => 12, length => 25,  is_blob => 0,  is_numeric => 0,  type => 'varchar(25)', default => ''},
        PrincipalId => 
		{read => 1, write => 1, sql_type => 4, length => 11,  is_blob => 0,  is_numeric => 1,  type => 'int(11)', default => '0'},
        RightName => 
		{read => 1, write => 1, sql_type => 12, length => 25,  is_blob => 0,  is_numeric => 0,  type => 'varchar(25)', default => ''},
        ObjectType => 
		{read => 1, write => 1, sql_type => 12, length => 25,  is_blob => 0,  is_numeric => 0,  type => 'varchar(25)', default => ''},
        ObjectId => 
		{read => 1, write => 1, sql_type => 4, length => 11,  is_blob => 0,  is_numeric => 1,  type => 'int(11)', default => '0'},
        DelegatedBy => 
		{read => 1, write => 1, sql_type => 4, length => 11,  is_blob => 0,  is_numeric => 1,  type => 'int(11)', default => '0'},
        DelegatedFrom => 
		{read => 1, write => 1, sql_type => 4, length => 11,  is_blob => 0,  is_numeric => 1,  type => 'int(11)', default => '0'},

 }
};


        eval "require RT::ACE_Overlay";
        if ($@ && $@ !~ qr{^Can't locate RT/ACE_Overlay.pm}) {
            die $@;
        };

        eval "require RT::ACE_Vendor";
        if ($@ && $@ !~ qr{^Can't locate RT/ACE_Vendor.pm}) {
            die $@;
        };

        eval "require RT::ACE_Local";
        if ($@ && $@ !~ qr{^Can't locate RT/ACE_Local.pm}) {
            die $@;
        };




=head1 SEE ALSO

This class allows "overlay" methods to be placed
into the following files _Overlay is for a System overlay by the original author,
_Vendor is for 3rd-party vendor add-ons, while _Local is for site-local customizations.  

These overlay files can contain new subs or subs to replace existing subs in this module.

Each of these files should begin with the line 

   no warnings qw(redefine);

so that perl does not kick and scream when you redefine a subroutine or variable in your overlay.

RT::ACE_Overlay, RT::ACE_Vendor, RT::ACE_Local

=cut


1;
