ad_page_contract {

    Convert acs-subsites to mgh-subsites.

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 
    @cvs-id $Id$

} {
    subsite_id:notnull
}

foreach one_subsite_id $subsite_id {
    set node_id [site_node::get_node_id_from_object_id -object_id $one_subsite_id]
    set name user$one_subsite_id
    db_dml q {
        update apm_packages
        set package_key = 'layout-managed-subsite'
        where package_id = :one_subsite_id
    }
    db_foreach {parameter_id default_value} [db_list_of_lists q {
        select ap.parameter_id, ap.default_value
        from apm_parameters ap
        where ap.package_key = 'layout-managed-subsite'
          and not exists (select 1
                          from apm_parameter_values apv
                          where apv.package_id = :one_subsite_id
                            and apv.parameter_id = ap.parameter_id}
        db_exec_plsql q {
            select apm_parameter_value__new(null, :one_subsite_id, :parameter_id, :default_value)
        }
    }
    site_node::update_cache -node_id $node_id
}
ad_returnredirect subsites
