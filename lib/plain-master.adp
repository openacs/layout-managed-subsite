<master src="/packages/openacs-default-theme/lib/plain-master">
<if @doc@ defined><property name="&doc">doc</property></if>
<if @body@ defined><property name="&body">body</property></if>
<if @head@ not nil><property name="head">@head;noquote@</property></if>
<if @focus@ not nil><property name="focus">@focus;noquote@</property></if>
<if @context@ not nil><property name="context">@context;noquote@</property></if>
<if @displayed_object_id@ not nil><property name="displayed_object_id">@displayed_object_id;literal@</property></if>
<property name="&navigation">navigation</property>
<property name="main_content_p">@main_content_p@</property>

<if @main_content_p@>
  <include src="@theme.template@" title="@title@" &="__adp_slave">
</if>
<else>
  <slave>
</else>
