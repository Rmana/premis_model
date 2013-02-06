class PremisGeneral < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  include Hydra::ModelMixins::RightsMetadata

  def attach_event_via_pid( pid ) 
    # for testing...
    # print "attribute=#{attrs[:node]}\n"
    if pid.nil?
      # if no pid event with which to create an event attached to this object... create default event
      pe = PremisEvent.create
    else
      # first make sure this pid is an event object 
      begin
        pe = PremisEvent.find(pid)
      rescue ActiveFedora::ObjectNotFoundError
        print "Event does not exist as pid=#{pid}" 
      end
    end
    if (!pe.nil?)
      self.premis_events<<(pe)
      self.save!
      # Note: relationship is explicitly bidirectional 
    else
      # TODO: if Premis Event does not exist
    end
  end

  def retrieve_event_pids
    # retrieve all events for object
    # if we have explicit RELS-EXT relationship, use next statement 
    self.premis_event_ids  
  end

  def create_right( pid ) 
    # for testing...
    # print "attribute=#{attrs[:node]}\n"
    if pid.nil?
      # if no pid rights with which to create a rights statement attached to this object... create default rights statement
      pr = PremisRight.create
    else
      # first make sure this pid is an right object 
      begin
        pr = PremisRight.find(pid)
      rescue ActiveFedora::ObjectNotFoundError
        print "Right Object does not exist as pid=#{pid}" 
      end
    end
    if (!pr.nil?)
      self.premis_rights<<(pr)
      self.save!
      # Note: relationship is explicitly bidirectional 
    else
      # TODO: if Premis Rights does not exist
    end
  end

  def retrieve_event_pids 
    # retrieve all events for object
    # if we have explicit RELS-EXT relationship, use next statement 
    self.premis_right_ids  
  end

end
