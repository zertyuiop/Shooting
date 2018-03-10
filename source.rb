class Shooting
  P, DYin, Yin, Xin, DXin, A, B, H, Eps = 100.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.1, 0.1
  def self.yfin(y0)
    yt0 = y0
    yt1 = yt0 + H * DYin
    2.upto(((B - A) / H).to_i) do |i|
      ytt = -P * i * H * H * H * Math.cos(yt1) + 2 * yt1 - yt0
      yt0 = yt1
      yt1 = ytt
    end
    yt1
  end
  def self.y(y0)
    yt0 = y0
    yt1 = yt0 + H * DYin
    p = File.new('lib.csv', 'w')
    p.puts DXin.to_s + ";" + yt0.to_s
    p.puts (DXin + H).to_s + ";" + yt1.to_s
    2.upto(((B - A) / H).to_i) do |i|
      ytt = -P * i * H * H * H * Math.cos(yt1) + 2 * yt1 - yt0
      yt0 = yt1
      yt1 = ytt
      p.puts (i * H).to_s + ";" + ytt.to_s
    end
    yt1
  end
  y1 = 1.0
  y0 = 0.0
  y00 = yfin(y0)
  y11 = 0.0
  loop do
    puts y1
    y11 = yfin(y1)
    break if (y11 - Yin).abs < Eps
    yt = ((y11 - Yin).abs * y0 - (y00 - Yin).abs * y1) / ((y11 - Yin).abs - (y00 - Yin).abs)
    y0 = y1
    y1 = yt
    y00 = y11
  end
  puts y1
  puts y11
  y(y1)
end