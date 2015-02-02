select crp.report_title,
       crp.report_desc,
       crp.report_date,
       cnl.council_name,
       ast.asset_name,
       aty.system_code_desc as asset_type,
       ifnull(sum(low_renew.work_cost),0) as low_renew_work_cost,
       ifnull(sum(low_upgrd.work_cost),0) as low_upgrd_work_cost,
       ifnull(sum(med_renew.work_cost),0) as med_renew_work_cost,
       ifnull(sum(med_upgrd.work_cost),0) as med_upgrd_work_cost,
       ifnull(sum(hgh_renew.work_cost),0) as hgh_renew_work_cost,
       ifnull(sum(hgh_upgrd.work_cost),0) as hgh_upgrd_work_cost
from council_reports  crp
inner join councils         cnl on cnl.id = crp.council_id
inner join report_assets    rpa on rpa.council_report_id = crp.id
inner join assets           ast on ast.id = rpa.asset_id
inner join asset_components acp on acp.asset_id = ast.id
inner join system_codes     aty on aty.system_code_type = 'ASSET_TYPE'
                               and aty.system_code = ast.asset_type_code
left join proposed_works low_renew on low_renew.council_report_id = crp.id
                                  and low_renew.asset_component_id = acp.id
                                  and low_renew.priority_level_code = 'LOW'
                                  and low_renew.cost_type_code = 'RENEWAL'
left join proposed_works low_upgrd on low_upgrd.council_report_id = crp.id
                                  and low_upgrd.asset_component_id = acp.id
                                  and low_upgrd.priority_level_code = 'LOW'
                                  and low_upgrd.cost_type_code = 'UPGRADE'
left join proposed_works med_renew on med_renew.council_report_id = crp.id
                                  and med_renew.asset_component_id = acp.id
                                  and med_renew.priority_level_code = 'MEDIUM'
                                  and med_renew.cost_type_code = 'RENEWAL'
left join proposed_works med_upgrd on med_upgrd.council_report_id = crp.id
                                  and med_upgrd.asset_component_id = acp.id
                                  and med_upgrd.priority_level_code = 'MEDIUM'
                                  and med_upgrd.cost_type_code = 'UPGRADE'
left join proposed_works hgh_renew on hgh_renew.council_report_id = crp.id
                                  and hgh_renew.asset_component_id = acp.id
                                  and hgh_renew.priority_level_code = 'HIGH'
                                  and hgh_renew.cost_type_code = 'RENEWAL'
left join proposed_works hgh_upgrd on hgh_upgrd.council_report_id = crp.id
                                  and hgh_upgrd.asset_component_id = acp.id
                                  and hgh_upgrd.priority_level_code = 'HIGH'
                                  and hgh_upgrd.cost_type_code = 'UPGRADE'
where crp.id = $P{council_report_id}
group by crp.report_title,
       cnl.council_name,
       ast.asset_name