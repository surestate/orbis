module Admin::ClientsHelper
  def clients_table
    returning [] do |arr|
      arr << %(<table class="tbl-standard">)
      arr << %(<tr>)
      arr << %(<th>#{check_box_tag('select-all')}</th>)
      arr << %(<th>Company name</th>)
      arr << %(<th>First name</th>)
      arr << %(<th>Last name</th>)
      arr << %(<th>Email</th>)
      arr << %(<th>Telephone</th>)
      arr << %(<th width='105px'></th>)
      arr << %(</tr>)
      arr << client_rows(@clients)
      arr << %(</table>)
    end
  end

private
  def client_rows(users)
    returning [] do |arr|
      users.each_with_index do |row, row_index|
        arr << %(<tr class="#{row_index % 2 == 0 ? 'even': 'odd'}">)
        arr << %(<td>#{check_box_tag(row.id)}</td>)
        arr << %(<td>#{row.company_name}</td>)
        arr << %(<td>#{row.firstname}</td>)
        arr << %(<td>#{row.lastname}</td>)
        arr << %(<td>#{row.email}</td>)
        arr << %(<td>#{row.telephone}</td>)
        arr << %(<td>#{image_link_to('icons/ico-view.png', 'view', admin_user_path(row.id))})
        arr << %(  #{image_link_to('icons/ico-edit.png','edit', edit_admin_user_path(row.id))})
        arr << %(  #{image_link_to('icons/ico-del.png', 'delete', { :action => :destroy, :id => row }, nil, :method => :delete)}</td>)
        arr << %(</tr>)
      end
    end
  end
end
