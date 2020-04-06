class BlockDevice < Inspec.resource(1)
  name 'block_device'
  desc 'Test a Linux block device'

  example "
    describe block_device('/dev/xvda') do
      it { should exist }
      its('size_gb') { should eq 8 }
    end
  "

  def initialize(device)
    @device = device
  end

  def exist?
    inspec.file(@device).exist?
  end

  def size_gb
    lsblk = inspec.command("lsblk -b --noheadings --output SIZE --raw #{@device}")
    return (lsblk.stdout.strip.to_i / 1024**3).ceil()
  end

  def to_s
    "Block device #{@device}"
  end
end
