# $Header$
# (c) 1996-1999 Jesse Vincent <jesse@fsck.com>
# This software is redistributable under the terms of the GNU GPL

package RT::Watchers;
require RT::EasySearch;
require RT::Watcher;
@ISA= qw(RT::EasySearch);


# {{{ sub new 
sub new  {
  my $pkg= shift;
  my $self = SUPER::new $pkg;
  
  $self->{'table'} = "Watchers";
  $self->{'primary_key'} = "id";
  $self->_Init(@_);
  return($self);
}
# }}}

# {{{ sub Limit 
sub Limit  {
  my $self = shift;
  my %args = ( ENTRYAGGREGATOR => 'AND',
	       @_);

  $self->SUPER::Limit(%args);
}
# }}}

# {{{ sub LimitToTicket
sub LimitToTicket { 
  my $self = shift;
  my $ticket = shift;
  $self->Limit( ENTRYAGGREGATOR => 'OR',
		FIELD => 'Value',
		VALUE => $ticket);
  $self->Limit (ENTRYAGGREGATOR => 'AND',
		FIELD => 'Scope',
		VALUE => 'Ticket');
}
# }}}

# {{{ sub LimitToQueue 
sub LimitToQueue  {
  my $self = shift;
  my $queue = shift;
  $self->Limit (ENTRYAGGREGATOR => 'OR',
		FIELD => 'Value',
		VALUE => $queue);
  $self->Limit (ENTRYAGGREGATOR => 'AND',
		FIELD => 'Scope',
		VALUE => 'Queue');
}
# }}}

# {{{ sub LimitToType 
sub LimitToType  {
  my $self = shift;
  my $type = shift;
  $self->Limit(FIELD => 'Type',
	       VALUE => "$type");
}
# }}}

# {{{ sub LimitToRequestors 
sub LimitToRequestors  {
  my $self = shift;
  $self->LimitToType("Requestor");
}
# }}}

# {{{ sub LimitToCc 
sub LimitToCc  {
    my $self = shift;
    $self->LimitToType("Cc");
}
# }}}

# {{{ sub LimitToAdminCc 
sub LimitToAdminCc  {
    my $self = shift;
    $self->LimitToType("AdminCc");
}
# }}}


# {{{ sub Emails 

# Return a (reference to a) list of emails
sub Emails  {
    my $self = shift;
    my $type = shift;

    $self->{is_modified}++;
    $self->LimitToType($type)
	if $type;
    # List is a list of watcher email addresses
    my @list;
    # Here $w is a RT::WatcherObject
    while (my $w=$self->Next()) {
	push(@list, $w->Email);
    }
    return \@list;
}
# }}}

# {{{ sub EmailsAsString

# Returns the RT::Watchers->Emails as a comma seperated string
sub EmailsAsString {
  my $self = shift;
  return(join(", ",@{$self->Emails}));
}
# }}}

# {{{ sub NewItem 
sub NewItem  {
  my $self = shift;
  my $Handle = shift;
  my $item;
 use RT::Watcher;
  $item = new RT::Watcher($self->CurrentUser);
  return($item);
}
# }}}
1;




