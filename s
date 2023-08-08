
[1mFrom:[0m /home/ec2-user/environment/nagano_cake/app/controllers/public/orders_controller.rb:30 Public::OrdersController#confirm:

    [1;34m12[0m: [32mdef[0m [1;34mconfirm[0m
    [1;34m13[0m:  @order = [1;34;4mOrder[0m.new(order_params)
    [1;34m14[0m: [32mcase[0m params[[33m:order[0m][[33m:address[0m]
    [1;34m15[0m: [32mwhen[0m [31m[1;31m"[0m[31m0[1;31m"[0m[31m[0m
    [1;34m16[0m:   @order.postal_code = current_customer.postal_code
    [1;34m17[0m:   @order.address = current_customer.address
    [1;34m18[0m:   @order.name = current_customer.last_name + current_customer.first_name
    [1;34m19[0m: [32mwhen[0m [31m[1;31m"[0m[31m1[1;31m"[0m[31m[0m
    [1;34m20[0m:   @address = [1;34;4mAddress[0m.find(params[[33m:order[0m][[33m:address_id[0m])
    [1;34m21[0m:   @order.postal_code = @address.postal_code
    [1;34m22[0m:   @order.address = @address.address
    [1;34m23[0m:   @order.name = @address.name
    [1;34m24[0m: [32mwhen[0m [31m[1;31m"[0m[31m2[1;31m"[0m[31m[0m
    [1;34m25[0m:   @address = [1;34;4mAddress[0m.new
    [1;34m26[0m:   @order.postal_code = @address.postal_code
    [1;34m27[0m:   @order.address = @address.address
    [1;34m28[0m:   @order.name = @address.name
    [1;34m29[0m: [32mend[0m
 => [1;34m30[0m: pry-byebug
    [1;34m31[0m: [32mend[0m

