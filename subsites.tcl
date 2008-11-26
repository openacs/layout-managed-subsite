ad_page_contract {

    List acs-subsites and offer to convert them to mgh-subsites.

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id$

}

db_multirow -extend {convert_url subsite_url} acs_subsites q {
    select package_id as subsite_id
    from apm_packages
    where package_key = 'acs-subsite'
    order by subsite_id
} {
    set convert_url [export_vars -base convert-subsites {subsite_id}]
    set subsite_url [site_node::get_url_from_object_id -object_id $subsite_id]
}

template::list::create \
    -name acs_subsites \
    -multirow acs_subsites \
    -key subsite_id \
    -elements {
        subsite_url {
            label {Subsite URL}
        }
        convert {
            label {Convert to a layout managed subsite}
            link_url_col convert_url
            link_html { title Convert class button }
            display_template {Convert}
        }
    }

