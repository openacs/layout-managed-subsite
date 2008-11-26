ad_page_contract {

    Main administration page for the layout manager package

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id$
} { }

if { ![layout::pageset::initialized] } {
    ad_returnredirect configure
    ad_script_abort
}

set context [list Admin]

ad_return_template
