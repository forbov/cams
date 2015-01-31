module CouncilReportsHelper
  def assets_not_in_report(report)
    return Asset.find_by_sql("select ast.id, ast.asset_name, 0 as add_asset 
                              from   assets        ast
                              where  ast.council_id = " + report.council_id.to_s +
                            " and    ast.id not in (select rpa.asset_id
                                                    from   report_assets rpa
                                                    where  rpa.council_report_id = " + report.id.to_s + ")")
  end
end
