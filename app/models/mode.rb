Mode = Hash.new{|h, k| h[k] = k}.merge(
  'rb' => 'ruby',
  'js' => 'javascript'
)
