module ReportAssetsHelper
  def report_assets_ordered(report_id)
    return ReportAsset.find_by_sql("select rpa.asset_id,
                                                     ast.asset_name,
                                                     ast.asset_type_code
                                              from   report_assets rpa,
                                                     assets        ast
                                              where  rpa.council_report_id = " + report_id.to_s +
                                            " and    ast.id = rpa.asset_id
                                              order by ast.asset_type_code,
                                                       ast.id")
  end
end
