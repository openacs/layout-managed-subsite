<master src="/packages/openacs-default-theme/lib/plain-master">
<property name="&navigation">navigation</property>
<property name="main_content_p">@main_content_p@</property>

<if @main_content_p@>
  <include src="@theme.template@" title="@title@" &="__adp_slave">
</if>
<else>
  <slave>
</else>
