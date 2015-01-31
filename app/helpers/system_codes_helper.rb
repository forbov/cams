module SystemCodesHelper
  STATE_CODE_TYPE = 'STATE'
  USER_ROLE_CODE_TYPE = 'USER_ROLE'
  ASSET_TYPE_CODE_TYPE = 'ASSET_TYPE'
  PRIORITY_CATEGORY_CODE_TYPE = 'PRIORITY'
  ADDRESS_CODE_TYPE = 'ADDRESS'
  PRIORITY_LEVEL_CODE_TYPE = 'PTY_LEVEL'
  COST_TYPE_CODE_TYPE = 'COST_TYPE'
  
  def state_codes
    return code_set(STATE_CODE_TYPE)
  end
  
  def state_desc(state_code)
    return code_desc(STATE_CODE_TYPE, state_code)
  end
  
  def user_role_codes
    return code_set(USER_ROLE_CODE_TYPE)
  end
  
  def user_role_desc(user_role_code)
    return code_desc(USER_ROLE_CODE_TYPE, user_role_code)
  end
  
  def asset_type_codes
    return code_set(ASSET_TYPE_CODE_TYPE)
  end

  def asset_type_codes_for_council(council)
      codes = SystemCode.find_by_sql("select sys.system_code, 
                                             sys.system_code_desc
                                      from   system_codes sys,
                                             council_asset_types cat
                                      where  sys.system_code_type = '" + ASSET_TYPE_CODE_TYPE + "'
                                      and    cat.council_id = " + council.id.to_s +
                                    " and    cat.asset_type_code = sys.system_code
                                      order by sys.system_code")
      return codes  
  end
  
  def asset_type_desc(asset_type_code)
    return code_desc(ASSET_TYPE_CODE_TYPE, asset_type_code)
  end
  
  def priority_category_codes
    return code_set(PRIORITY_CATEGORY_CODE_TYPE)
  end
  
  def priority_category_desc(priority_category_code)
    return code_desc(PRIORITY_CATEGORY_CODE_TYPE, priority_category_code)
  end
  
  def address_type_codes
    return code_set(ADDRESS_CODE_TYPE)
  end
  
  def address_type_desc(address_type_code)
    return code_desc(ADDRESS_CODE_TYPE, address_type_code)
  end

  def priority_level_codes
    return code_set(PRIORITY_LEVEL_CODE_TYPE)
  end
  
  def priority_level_desc(priority_level_code)
    return code_desc(PRIORITY_LEVEL_CODE_TYPE, priority_level_code)
  end

  def cost_type_codes
    return code_set(COST_TYPE_CODE_TYPE)
  end
  
  def cost_type_desc(cost_type_code)
    return code_desc(COST_TYPE_CODE_TYPE, cost_type_code)
  end

  private
    def code_set(code_type)
      codes = SystemCode.select(:system_code, :system_code_desc).where(system_code_type: code_type).order('system_code ASC')
      return codes  
    end
  
  private
    def code_desc(code_type, code)
      system_code = SystemCode.find([code_type, code])
      return system_code.system_code_desc
    end
end
