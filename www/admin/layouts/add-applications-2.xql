<?xml version="1.0"?>

<queryset>

  <fullquery name="get_package_id">
    <querytext>
      select package_id
      from layout_pagesets
      where pageset_id = :pageset_id
    </querytext>
  </fullquery>

  <fullquery name="get_user_includelets">
    <querytext>
      select name
      from layout_includelets
      where application = :one_application
        and internally_manged_p = 'f'
    </querytext>
  </fullquery>

</queryset>
