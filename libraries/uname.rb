class Uname < Inspec.resource(1)
  name 'uname'

  desc 'Currently running kernel information'
  example "
    describe uname do
      its('release') { should cmp >= '2.6' }
    end
  "

  def initialize()
    @all = inspec.command('uname --all').stdout
    @release = inspec.command('uname --kernel-release').stdout.split("-")[0]
  end

  def to_s
    "Uname: '#{@all}'"
  end

  def release
    @release
  end

  private
end
