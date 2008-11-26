ad_page_contract {

  Build two-level tabbed navigation multirows for a pageset.

  @author Don Baccus (dhogaza@pacifier.com)

  $Id$
}

set user_id [ad_conn user_id]

set subsite_node_id [site_node::get_node_id_from_object_id -object_id [ad_conn subsite_id]]
set layout_manager_url \
    [lindex [site_node::get_children \
                -node_id $subsite_node_id \
                -package_key layout-managed-subsite] 0]

set package_id [site_node::get_object_id -node_id [site_node::get_node_id -url $layout_manager_url]]
set package_node_id [site_node::get_node_id_from_object_id -object_id $package_id]

set pageset_id [layout::pageset::get_user_pageset_id -package_id $package_id]

# set a default title in case an included application page doesn't set it.  Should move
# to the doc() array approach in the future.
set title ""

# No expr tag in the templating system ...
set main_content_p [expr { ![info exists page_num] }]

if { $main_content_p } {
    array set theme \
        [layout::theme::get \
            -name [layout::pageset::get_column_value -pageset_id $pageset_id -column theme]]
}
