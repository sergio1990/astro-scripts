def normalize_deg(raw_deg)
  return raw_deg if raw_deg >= 0 && raw_deg <= 360 

  delta = raw_deg < 0 ? 360 : -360
  normalize_deg(raw_deg + delta)
end

def deg_to_hours(deg)
  deg / 15.0
end

def human_dec_hours(dec_hours)
  hours = dec_hours.truncate
  rest = dec_hours - hours
  minutes = 60 * rest

  "#{hours} h #{minutes} m"
end

# Steps for calculations were taken from here - http://www.stargazing.net/kepler/altaz.html
puts 'Calculating the HA of the M13...'
puts 'The target date is 21 June 2021 23:00 UTC+3'

puts '=> Step 1 - Specifying and normalize income data'
ra=250.425 #d
dec=36.46667 #d
utc_time=20.0 #hrs
lat=50.5 #d
long=30.1 #d
year=2021
month=6
day=21
puts ''
puts '=> Step 2 - Days after J2000'
# https://thecynster.home.blog/2019/11/08/calculating-the-julian-date-and-j2000/
JD=367*year - (7*(year + ((month + 9)/12.0).ceil)/4.0).ceil - ((((year + (month - 9) / 7.0) / 100.0).ceil + 1) / 4.0).ceil + (275 * month / 9.0).ceil + day + 1721028.5 + utc_time / 24
J2000 = JD - 2451545.0

puts "JD = #{JD}"
puts "J2000 = #{J2000}"

puts ''
puts '=> Step 3 - Local Sidereal Time'

raw_lst = 100.46 + 0.985647 * J2000 + long + 15 * utc_time
puts "raw LST = #{raw_lst}"
LST = normalize_deg(raw_lst)
puts "LST = #{LST}"

puts ''
puts '=> Step 4 - Hour Angle'
HA = normalize_deg(LST - ra)
HA_hrs = deg_to_hours(HA)
puts "HA = #{HA} d"
puts "HA = #{HA_hrs} hrs = #{human_dec_hours(HA_hrs)}"
