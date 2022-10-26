class Admin::Billboards::BillboardSerializer < ActiveModel::Serializer
  attributes :id,:name,:title,:content,:image
end
