class Timesheet
  def self.status
    url = "http://timesheet-acceptance.carbonfive.com/api/status.json?api_token=#{ENV['TIMESHEET_API_TOKEN']}"
    response = HTTParty.get(url)
    JSON.parse(response.body)['worst_offenders'].keys
  end
end
