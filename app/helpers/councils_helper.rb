module CouncilsHelper
  def council_priority_weights_ordered(council_id)
    return Council.find_by_sql("select cpw.priority_item_id id,
                                       cpw.priority_weight,
                                       pri.priority_category_code,
                                       pri.priority_item_desc
                                from   council_priority_weights cpw,
                                       priority_items           pri
                                where  cpw.council_id = " + council_id.to_s +
                              " and    pri.id = cpw.priority_item_id
                                order by pri.priority_category_code,
                                         cpw.priority_item_id")
  end
  
  def asset_types_not_in_council(council)
    return Asset.find_by_sql("select sys.system_code as asset_type_code, 
                                     sys.system_code_desc as asset_type_desc,
                                     0 as add_asset_type 
                              from   system_codes    sys
                              where  sys.system_code_type = 'ASSET_TYPE'                     and    sys.system_code not in (select cat.asset_type_code
                                                             from   council_asset_types cat
                                                             where  cat.council_id = " + council.id.to_s + ")")
  end

end
