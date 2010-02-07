ad_page_contract {

  Build two-level tabbed navigation multirows for a pageset.

  @author Don Baccus (dhogaza@pacifier.com)

  $Id$
}

set user_id [ad_conn user_id]

set layout_manager_id [layout::package_id]
set layout_manager_node_id [site_node::get_node_id_from_object_id -object_id $layout_manager_id]
set layout_manager_url [site_node::get_url_from_object_id -object_id $layout_manager_id]

set pageset_id [layout::pageset::get_user_pageset_id -package_id $layout_manager_id]

# set a default title in case an included application page doesn't set it.  Should move
# to the doc() array approach in the future.
set title ""

# Create the multirow so other code that add to this can do so with multirow append
template::multirow create navigation group label href target \
    title lang accesskey class id tabindex 

# Grab the pages for the user pageset
db_multirow -cache_key pageset_${pageset_id}_multirow_${user_id} -append \
    -unclobber -extend {group target title lang accesskey class id} \
     navigation select_pageset_pages {} {
    set group main
    set href $layout_manager_url[ad_urlencode $href]
}

set show_applications_p [parameter::get -package_id [ad_conn subsite_id] \
                            -parameter ShowApplications -default 1]
set no_tab_application_list [parameter::get -package_id [ad_conn subsite_id] \
                                -parameter NoTabApplicationList -default ""]

subsite_navigation::define_pageflow -navigation_multirow navigation -group main -subgroup sub \
    -show_applications_p $show_applications_p \
    -no_tab_application_list $no_tab_application_list

if { !$show_applications_p } {
    array set package_node [site_node::get_from_url -exact -url [ad_conn package_url]]
    if { $package_node(parent_id) == $layout_manager_node_id &&
         [lsearch -exact $no_tab_application_list $package_node(package_key)] == -1 } {
        set instance_name [site_node::get_element -url [ad_conn package_url] \
                              -element instance_name]
        template::multirow append navigation main $package_node(instance_name) \
            [ad_conn package_url] "" $package_node(instance_name) "" \
            [template::multirow size navigation] "" \
            main-navigation-active [template::multirow size navigation]
    }
}

set pageset_page_p 0
array set page_url_map [parameter::get -package_id $layout_manager_id -parameter PageUrlMap -default ""]
for { set i 1 } { $i <= [template::multirow size navigation] } { incr i } {
    set tabindex [template::multirow get navigation $i tabindex]
    if { [info exists page_url_map($tabindex)] &&
         [regexp $page_url_map($tabindex) [ad_conn url]] ||
         [info exists page_num] && $tabindex == $page_num } {
        template::multirow set navigation $i id main-navigation-active
        set pageset_page_p 1
        break
    }
}

set show_tabs_p [expr { [template::multirow size navigation] > 1 || [parameter::get -package_id [ad_conn subsite_id] -parameter ShowSingleButtonNavbar -default 0]}]

if { !$pageset_page_p } {
    array set theme \
        [layout::theme::get \
            -name [layout::pageset::get_column_value -pageset_id $pageset_id -column theme]]
}

# No expr tag in the templating system ...
set main_content_p [expr { !$pageset_page_p }]
