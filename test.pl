#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 33;
use Tree::SEMETrie;

#print "# I'm testing Tree::SEMETrie version $Tree::SEMETrie::VERSION\n";

{ #Test initialization

	my $class_trie = Tree::SEMETrie->new();
	isa_ok $class_trie, 'Tree::SEMETrie',    "Class construction successful";
	my $instance_trie = $class_trie->new();
	isa_ok $instance_trie, 'Tree::SEMETrie', "Instance construction successful";

}

{ #Test basic functionality 

	my $trie = Tree::SEMETrie->new();

	ok $trie->add('a'),    'Inserts initial key';
	ok ! $trie->add('a'),  'Does not insert a preexisting key';
	ok $trie->add('aaaa'), 'Inserts a superstring';
	ok $trie->add('aa'),   'Inserts a substring';

	isa_ok $trie->find('a'),      'Tree::SEMETrie', 'Retrieval returns a SEMETrie';
	ok $trie->find('a'),          'Retrieves a known key';
	ok $trie->find('aaa'),        'Retrieves a known subkey';
	ok ! defined $trie->find('q'),'Does not retrieve an unknown key';

}

{ #Test key and value coverage

	my $trie = Tree::SEMETrie->new();

	ok ! $trie->add(undef),     'Does not insert undefed key';
	ok $trie->add(''),          'Inserts lexically false key';
	ok $trie->add('it works'),  'Inserts lexically true key';
	ok $trie->add(0),           'Inserts numerically false key';
	ok $trie->add(1),           'Inserts numerically true key';
	ok $trie->add(chr(0xac33)), 'Inserts unicode character key';

	ok $trie->add('a', undef),      'Inserts undefed value';
	ok $trie->add('b', 0),          'Inserts numerically false value';
	ok $trie->add('c', 1),          'Inserts numerically true value';
	ok $trie->add('d', ''),         'Inserts lexically false value';
	ok $trie->add('e', 'stuff'),    'Inserts lexically true value';
	ok $trie->add('f', []),         'Inserts array reference value';
	ok $trie->add('g', {}),         'Inserts hash reference value';
	ok $trie->add('h', $trie->new), 'Inserts blessed value';
	ok $trie->add('i', undef),      'Inserts same value twice';

	ok ! defined $trie->find('a')->value,      "Retrieves undefed value";
	ok $trie->find('b')->value == 0,           "Retrieves numerically false value";
	ok $trie->find('c')->value == 1,           "Retrieves numerically true value";
	ok $trie->find('d')->value eq '',          "Retrieves lexically false value";
	ok $trie->find('e')->value eq 'stuff',     "Retrieves lexically true value";
	ok ref $trie->find('f')->value eq 'ARRAY', "Retrieves array reference value";
	ok ref $trie->find('g')->value eq 'HASH',  "Retrieves hash reference value";
	ok ref $trie->find('h')->value,            "Retrieves blessed value";

}

1;
