package Tree::SEMETrie;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.01';

BEGIN {
	my $PACKAGE = __PACKAGE__;
	my $IMPLEMENTATION = 'Tree::SEMETrie::Fast';

	my @METHODS = qw{new childs value has_childs has_value add find};

	no strict 'refs';
	no warnings 'once';
	eval "require $IMPLEMENTATION";
	*{"$PACKAGE\::$_"} = \*{"$IMPLEMENTATION\::$_"} for @METHODS;
	*{"$PACKAGE\::children"} = \*{"$IMPLEMENTATION\::childs"};
	*{"$PACKAGE\::has_children"} = \*{"$IMPLEMENTATION\::has_childs"};
	*{"$PACKAGE\::insert"} = \*{"$IMPLEMENTATION\::add"};
	*{"$PACKAGE\::lookup"} = \*{"$IMPLEMENTATION\::find"};

	*{"$PACKAGE\::implementation"} = sub { $IMPLEMENTATION };
};

#Traversal

#Gets every path to every stored value as [path, value] pairs
sub all {
	my $self = shift;

	my @results;
	for (my $iterator = $self->iterator; ! $iterator->is_done; $iterator->next) {
		push @results, [$iterator->key, $iterator->value];
	}

	return @results;
}

#Get a Tree::SEMETrie::Iterator for efficient trie traversal
sub iterator { Tree::SEMETrie::Iterator->new($_[0]) }

1;

__END__

=head1 NAME

Tree::SEMETrie - The great new Tree::SEMETrie!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Tree::SEMETrie;

    my $foo = Tree::SEMETrie->new();
    ...

=head1 SUBROUTINES/METHODS

=head2 Constructors

=head3 new

=head2 Root Accessors/Mutators

=head3 children

Get a list of all immediate B<[$path, $child_node]> pairs.

=head3 childs

Alias for children.

=head3 value

Get/Set the value associated with the root.

=head2 Root Verifiers

=head3 has_children

Returns true if the root has any child paths.

=head3 has_childs

Alias for has_children.

=head3 has_value

Returns true if the root has an associated value.

=head2 Trie Accessors/Mutators

=head3 add

=head3 erase

=head3 find

=head3 insert

=head3 lookup

=head3 merge

=head3 prune

=head3 remove

=head2 Trie Traversal

=head3 all

Gets every path to every stored value as [path, value] pairs.

=head3 iterator

Get a Tree::SEMETrie::Iterator for efficient trie traversal.

=head1 AUTHOR

Aaron Cohen, C<< <aarondcohen at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tree-semetrie at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tree-SEMETrie>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tree::SEMETrie


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tree-SEMETrie>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tree-SEMETrie>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tree-SEMETrie>

=item * Search CPAN

L<http://search.cpan.org/dist/Tree-SEMETrie/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Aaron Cohen.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
