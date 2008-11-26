<?xml version="1.0"?>

<queryset>

  <fullquery name="get_mounted_applications">
    <querytext>
      select distinct ap.package_key , ap.package_id
      from layout_includelets li, apm_packages ap
      where ap.package_id in ([join $package_id_list ,])
        and apm_package__is_child(li.application, ap.package_key)
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
                    from layout_includelets li
                    where apt.package_key = li.application)
        and not apt.package_key in ('[join $package_key_list "','"]')
        and apt.package_type = 'apm_application'
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
