# == Class: ucarp
#
# This module manages UCARP.
#
class ucarp {
  include ucarp::install
  include ucarp::config
}
