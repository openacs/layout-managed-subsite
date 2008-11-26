ad_page_contract {
    Page that displays a list of pagesets with edit links belonging to this layout manager instance.

    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date 
    @cvs-id $Id$
} { }

set package_id [ad_conn package_id]
db_multirow pagesets get_pagesetss {}

ad_return_template
