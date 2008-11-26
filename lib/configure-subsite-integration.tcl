ad_page_contract {
    Configure the layout manager package's interaction with the subsite package in the 'ole
    look and feel department.
} {
}

ad_form -name configure-subsite-integration -form {
    {template_style:integer(radio)
        {options {{"Tabbed navigation" 0}
                  {"Plain navigation (works best if there's only one layout manager page)" 1}
                  {"Use my existing custom master template" 2}}}
        {values {0}}
        {label "Choose master template?"}
    }
    {pageset_index_page_p:boolean(radio)
        {options {{Yes 1} {No 0}}}
        {values {1}}
        {label "Should the parent subsite serve the layout manager package as its index page?"}
    }
    {show_single_button_navbar_p:boolean(radio)
        {options {{Yes 1} {No 0}}}
        {values {0}}
        {label "Should we show the navigation tabs when there's only one of them?"}
    }
} -on_submit {

    switch $template_style {

        0 {parameter::set_value \
               -parameter DefaultMaster \
               -package_id [ad_conn subsite_id] \
               -value /packages/layout-managed-subsite/lib/tabbed-master
        }

        1 {parameter::set_value \
               -parameter DefaultMaster \
               -package_id [ad_conn subsite_id] \
               -value /packages/layout-managed-subsite/lib/plain-master
        }

        2 {}

    }

    if { $pageset_index_page_p } {
        parameter::set_value \
            -parameter IndexInternalRedirectUrl \
            -package_id [ad_conn subsite_id] \
            -value /packages/layout-managed-subsite/www/
    }

    parameter::set_value \
        -parameter ShowSingleButtonNavbar \
        -package_id [ad_conn package_id] \
        -value $show_single_button_navbar_p

    template::wizard::forward
}

template::wizard::submit configure-subsite-integration -buttons {back next}
