class PremisContainer < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  include Hydra::ModelMixins::RightsMetadata

  after_save :create_premis
  has_metadata :name => 'descMetadata', :type => PremisContainerDatastream

  # has_metadata :name => 'PremisContainerInternal', :type => ActiveFedora::SimpleDatastream do |c|
  #    c.field :creator, :string
  # end
  # delegate_to :PremisContainerInternal, [:creator]

  has_many :premis_objects, :class_name=>"premis_object", :property => :is_object_of
  has_many :premis_agents, :class_name=>"premis_agent", :property => :is_agent_of
  # has_and_belongs_to_many :premis_agents, :class_name=>"premis_agent", :property => :is_agent_of

  def create_premis
    self.con_agent
    self.con_object
  end 

  def con_agent
    self.datastreams["descMetadata"].find_by_terms(:agent_premis).each do |node|
       pa = PremisAgent.new(:node=>node)
       pa.premis_container = self
       pa.save
    end 
  end
  
  def con_object
    self.datastreams["descMetadata"].find_by_terms(:object_premis).each do |node|
       po = PremisObject.new(:node=>node)
       po.premis_container = self
       po.save
    end 
  end
 
    # create premis events
   
    # create premis rights
   
end
