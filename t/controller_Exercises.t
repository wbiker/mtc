use strict;
use warnings;
use Test::More;


use Catalyst::Test 'mtc';
use mtc::Controller::Exercises;

ok( request('/exercises')->is_success, 'Request should succeed' );
done_testing();
