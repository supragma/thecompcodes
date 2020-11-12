# frozen_string_literal: true
require 'securerandom'
# Controller for the get it now service controller.
class GetitnowController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Get It Now view method.
  def index
    render 'index'
  end

  # Get It Now post method.
  def create
    lotsize = 0
    if params["lotsize"] != "" && 
       params["lotsize"] != nil &&
       regex_is_number?(params["lotsize"])
      lotsize = params["lotsize"].to_i
    end
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
                            lot_size: lotsize,
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
                            consider_no: params["consider_no"] == "yes",
                            referral: params["referral"]
                           )
    # Create the cooresponding user.
    user = User.create(email: params["email"], first_name: params["firstname"],
                       last_name: params["lastname"], phone: params["phone"],
                       refcode: SecureRandom.urlsafe_base64(7).upcase!,
                       zip: params["zip"], getquote_id: quote.id)
    # Send out emails to notify all parties.
    GetQuoteMailer.new_quote("christian@thecompcodes.com", quote).deliver
    GetQuoteMailer.new_quote("navraj@thecompcodes.com", quote).deliver

    # Send a welcome email.
    #SendHelloMailer.send_hello(params["email"], quote).deliver_later(wait: 5.minutes)

    # Don't send a quote if it's greater than 3000 sqft.
    if quote["size"] == "3000+"
      # Do nothing. This is a manual request.
    else
      SendQuoteMailer.send_quote(params["email"], quote).deliver
      SendQuoteMailer.send_quote("christian@thecompcodes.com", quote).deliver_later(wait: 62.minutes)
    end

    # Send email telling users about their reference code.
    #ReferenceCodeMailer.send_ref_code("navraj@thecompcodes.com", user).deliver
    #ReferenceCodeMailer.send_ref_code("christian@thecompcodes.com", user).deliver
    #ReferenceCodeMailer.send_ref_code(params["email"], user).deliver_later(wait:65.minutes)
    redirect_to contactus_url(request.parameters)
  end

  private

  def regex_is_number?(string)
    no_commas =  string.gsub(',', '')
    matches = no_commas.match(/-?\d+(?:\.\d+)?/)
    if !matches.nil? && matches.size == 1 && matches[0] == no_commas
      return true
    else
      return false
    end
  end
end
