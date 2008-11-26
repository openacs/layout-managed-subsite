ad_page_contract {

    Make exact copies of a set of elements.

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id$

} {
    element_id:naturalnum,notnull,multiple
    return_url:notnull
}

set copied_element_ids [list]

db_transaction {
    foreach one_element_id $element_id {

        # For some reason I'm getting dupes in my element_id list from the checkboxes
        # set up by the list widget on the previous page.

        if { [lsearch -exact $copied_element_ids $one_element_id] == -1 } {
            lappend copied_element_ids $one_element_id
            layout::element::copy -element_id $one_element_id -state hidden
        }
    }
}
ad_returnredirect $return_url
