#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 25;
use Test::Exception;
use Tree::SEMETrie;

my $trie = Tree::SEMETrie->new();

#Check that a trie will only find what was inserted
ok ! $trie->find('a'), 'Non-existent key not found';

#Check that undefined keys cannot be stored
dies_ok { $trie->add(undef) }     'Undefined key can not be stored';
ok ! defined($trie->find(undef)), 'Undefined key was not retrieved';

#Check that a key can be stored and retrieved
ok $trie->add('a'),                    'Key without defined value added successfully';
ok $trie->find('a'),                   'Key without defined value found';
ok $trie->find('a')->has_value,        'Key without defined value has value';
ok ! defined($trie->find('a')->value), 'Value of key without defined value is undefined';

#Check that a key-value pair can be stored and retrieved
ok $trie->add('b', 2),          'Key with defined value added successfully';
ok $trie->find('b'),            'Key with defined value found';
ok $trie->find('b')->has_value, 'Key with defined value has value';
is $trie->find('b')->value, 2,  'Key with defined value fetched successfully';

#Check that the empty string is equivalent to the root
ok $trie->add('', 'root-value'),  'Empty string key added successfully';
is_deeply $trie->find(''), $trie, 'Empty string key is equivalent to root';

#Check that numerical values are not an issue
ok $trie->add(0, 6),          'Numerically false key added successfully';
ok $trie->find(0),            'Numerically false key found';
ok $trie->find(0)->has_value, 'Numerically false key has value';
is $trie->find(0)->value, 6,  'Numerically false key fetched successfully';

ok $trie->add(27, 8),          'Numerical key added successfully';
ok $trie->find(27),            'Numerical key found';
ok $trie->find(27)->has_value, 'Numerical key has value';
is $trie->find(27)->value, 8,  'Numerical key fetched successfully';

#Check that unicode is not an issue
ok $trie->add("\x{b3c3}", 10),         'Unicode key added succesffuly';
ok $trie->find("\x{b3c3}"),            'Unicode key found';
ok $trie->find("\x{b3c3}")->has_value, 'Unicode key has value';
is $trie->find("\x{b3c3}")->value, 10, 'Unicode key fetched successfully';

