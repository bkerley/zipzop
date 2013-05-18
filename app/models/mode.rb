Mode = Hash.new{|h, k| h[k] = k}.merge(
  'rb' => 'ruby',
  'ru' => 'ruby',
  'js' => 'javascript'
)
