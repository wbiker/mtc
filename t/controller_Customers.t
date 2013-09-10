use strict;
use warnings;
use Test::More;


use Catalyst::Test 'mtc';
use mtc::Controller::Customers;

ok( request('/customers')->is_success, 'Request should succeed' );
done_testing();
