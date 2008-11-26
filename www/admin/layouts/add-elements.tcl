ad_page_contract {

    Add one or more includelets as new elements in the given pageset

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id$

} {
    pageset_id:naturalnum,notnull
    package_id:naturalnum,notnull
    name:notnull,multiple
    return_url:notnull
}

permission::require_permission -object_id $pageset_id -privilege admin

set added_names [list]

db_transaction {
    foreach one_name $name {

        # For some reason I'm getting dupes in my name list from the checkboxes
        # set up by the list widget on the previous page.

        if { [lsearch -exact $added_names $one_name] == -1 } {

            lappend added_names $one_name

            layout::element::new \
                -pageset_id $pageset_id \
                -package_id $package_id \
                -includelet_name $one_name \
                -state hidden \
                -initialize

        }
    }
}
ad_returnredirect $return_url
