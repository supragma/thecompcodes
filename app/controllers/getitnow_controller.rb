# frozen_string_literal: true

# Controller for the get it now service controller.
class GetitnowController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Get It Now view method.
  def index
    render 'index'
  end

  # Get It Now post method.
  def create
    quote = Getquote.create(json_blob: params.to_s,
                            first_name: params["firstname"],
                            last_name: params["lastname"],
                            email: params["email"],
                            address: params["address"],
                            zip: params["zip"],
                            phone: params["phone"],
                            details: params["details"],
                            authorized: params["authorized"] == "yes",
                            contractor: params["contractor"] == "yes",
                            prefab: params["prefab"] == "yes",
                            dev_company: params["devcompany"] == "yes",
                            location: params["location"],
                            new_construction: params["newconstruction"] == "yes",
                            adding: params["adding"] == "yes",
                            remodel: params["remodel"] == "yes",
                            complete_remodel: params["completeremodel"] == "yes",
                            tenant_improvement: params["tenantimprovement"] == "yes",
                            structural_repair: params["structurerepair"] == "yes",
                            structural_eng: params["structure-eng"] == "yes",
                            project_other: params["project-other"],
                            size: params["size"],
                            interior_alt: params["interioralt"] == "yes",
                            exterior_alt: params["exterioralt"] == "yes",
                            earth_work: params["earthwork"] == "yes",
                            site_improvements: params["siteimprovements"] == "yes",
                            mech_elect_plumb: params["mech-elect-plumb"] == "yes",
                            sewer: params["sewer"] == "yes",
                            change_use: params["changeuse"] == "yes",
                            ccr: params["ccr"],
                            consider_zoning: params["considerzoning"] == "yes",
                            consider_environment: params["considerenvironment"] == "yes",
                            consider_slope: params["considerslope"] == "yes",
                            consider_other: params["considerother"] == "yes",
                            consider_dont_know: params["considerdontknow"] == "yes",
                            consider_no: params["consider_no"] == "yes"
                           )

    # Send out emails to notify all parties.
    GetQuoteMailer.new_quote("christian@thecompcodes.com", quote).deliver
    GetQuoteMailer.new_quote("navraj@thecompcodes.com", quote).deliver
    SendHelloMailer.send_hello(params["email"], quote).deliver_later(wait: 15.minutes)
    SendQuoteMailer.send_quote(params["email"], quote).deliver_later(wait: 1.hour)
    redirect_to contactus_url(request.parameters)
  end
end
