ad_page_contract {

    Generate a list of applications that are supported by includelets.

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id$
}

set context [list "Add Applications"]
set return_url [ad_conn url]?[ad_conn query]
ad_return_template