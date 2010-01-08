ad_page_contract {

    Generate a list of applications that are supported by includelets.

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id$
}

set doc(title) [_ layout-managed-subsite.Add_applications]
set context [list $doc(title)]
set return_url [ad_conn url]?[ad_conn query]
ad_return_template
