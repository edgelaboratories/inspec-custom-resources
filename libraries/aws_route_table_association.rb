class AWSRouteTableAssociation < Inspec.resource(1)
  name 'aws_route_table_association'
  desc 'Test the configuration of a class AWS Route Table Association'
  example "
    describe aws_vpc_endpoint('rtb-1234', 'rtbassoc-1234') do
      it { should exist }
      it { should be_main }
      its('id') { should eq 'rtbassoc-1234' }
      its('subnet_id') { should eq 'subnet-1234' }
      its('route_table_id') { should eq 'rtb-1234' }
    end
  "

  def initialize(route_table_id, route_table_association_id)
    @route_table_association_id = route_table_association_id
    @route_table_association = get_route_table_association(route_table_id, route_table_association_id)
  end

  def to_s
    "Route Table Association #{@route_table_association_id}"
  end

  def exists?
    @route_table_association != nil
  end

  def main?
    @vpc_endpoint.main
  end

  def id
    @route_table_association.id
  end

  def subnet_id
    @route_table_association.subnet_id
  end

  def route_table_id
    @route_table_association.route_table_id
  end

  private

  def get_route_table_association(route_table_id, route_table_association_id)
    association = nil
    ec2 = Aws::EC2::Client.new
    route_table = ec2.describe_route_tables(route_table_ids: [route_table_id]).route_tables[0]
    associations = route_table.associations
    associations.each do |assoc|
      if assoc['route_table_association_id'] == route_table_association_id
        association = assoc
      end
    end
    association
  end
end
