class Timesheet
  def self.status
    timesheet_url = ENV.fetch("TIMESHEET_URL", "http://timesheet-acceptance.carbonfive.com")
    url = "#{timesheet_url}/api/status.json?api_token=#{ENV['TIMESHEET_API_TOKEN']}"
    response = HTTParty.get(url)
    JSON.parse(response.body)['worst_offenders'].keys
  end
end
