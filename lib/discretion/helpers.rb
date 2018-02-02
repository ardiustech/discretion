module Discretion
  class << self
    def in_console?
      defined?(Rails::Console).present?
    end

    def in_test?
      Rails.env.test?
    end

    def can_see_records?(viewer, *records)
      records.all? { |record| Discretion.can_see_record?(viewer, record) }
    end

    def omnisciently
      # Calling Proc.new will create a Proc from the implicitly given block to
      # the current method.
      # cf. http://ruby-doc.org/core-2.5.0/Proc.html#method-c-new
      with_viewer(Discretion::OMNISCIENT_VIEWER, &Proc.new)
    end

    def omnipotently
      # Calling Proc.new will create a Proc from the implicitly given block to
      # the current method.
      # cf. http://ruby-doc.org/core-2.5.0/Proc.html#method-c-new
      with_viewer(Discretion::OMNIPOTENT_VIEWER, &Proc.new)
    end

    private

    def with_viewer(viewer)
      orig_viewer = Discretion.current_viewer
      Discretion.set_current_viewer(viewer)
      yield
    ensure
      Discretion.set_current_viewer(orig_viewer)
    end
  end
end
