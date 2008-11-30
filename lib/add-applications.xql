<?xml version="1.0"?>

<queryset>

  <fullquery name="get_services">
    <querytext>
      select apt.package_key
      from apm_package_types apt
      where exists (select 1
                    from layout_includelets li
                    where apt.package_key = li.application)
        and apt.package_type = 'apm_service'
      order by apt.package_key
    </querytext>
  </fullquery>

  <fullquery name="get_service_includelets">
    <querytext>
      select li.title, count(*)
      from layout_includelets li, layout_elements le
      where le.package_id = :subsite_id
        and le.includelet_name = li.name
        and li.application = :package_key
      group by li.title
      order by li.title
    </querytext>
  </fullquery>

  <fullquery name="get_mounted_applications">
    <querytext>
      select distinct ap.package_key , ap.package_id
      from layout_includelets li, apm_packages ap, site_nodes s, apm_package_types apt
      where s.parent_id = :subsite_node_id
        and s.object_id = ap.package_id
        and apm_package__is_child(li.application, ap.package_key)
        and apt.package_key = ap.package_key
        and apt.package_type = 'apm_application'
    </querytext>
  </fullquery>

  <fullquery name="get_mounted_includelets">
    <querytext>
      select li.title, count(*)
      from layout_includelets li, layout_elements le
      where le.package_id = :package_id
        and le.includelet_name = li.name
      group by li.title
      order by li.title
    </querytext>
  </fullquery>

  <fullquery name="get_available_applications">
    <querytext>
      select apt.package_key
      from apm_package_types apt
      where exists (select 1
                    from layout_includelets li, site_nodes s
                    where apm_package__is_child(li.application, apt.package_key))
        and not exists (select 1
                        from site_nodes s, apm_packages ap
                        where s.parent_id = :subsite_node_id
                          and s.object_id = ap.package_id
                          and ap.package_key = apt.package_key)
        and apt.package_type = 'apm_application'
      order by apt.package_key
    </querytext>
  </fullquery>

  <fullquery name="get_available_includelets">
    <querytext>
      select title as includelet
      from layout_includelets
      where apm_package__is_child(application, :package_key)
      order by title
    </querytext>
  </fullquery>

</queryset>
