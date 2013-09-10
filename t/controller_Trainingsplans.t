use strict;
use warnings;
use Test::More;


use Catalyst::Test 'mtc';
use mtc::Controller::Trainingsplans;

ok( request('/trainingsplans')->is_success, 'Request should succeed' );
done_testing();
