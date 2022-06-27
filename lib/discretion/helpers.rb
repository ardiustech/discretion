module Discretion
  class << self
    def in_console?
      defined?(Rails::Console).present?
    end

    def in_test?
      Rails.env.test?
    end

    def try_to(viewer)
      orig_viewer = Discretion.current_viewer
      Discretion.set_current_viewer(viewer)
      yield
      true
    rescue Discretion::CannotSeeError, Discretion::CannotWriteError
      false
    ensure
      Discretion.set_current_viewer(orig_viewer)
    end

    def omnisciently(&block)
      acting_as(Discretion::OMNISCIENT_VIEWER, &block)
    end

    def omnipotently(&block)
      acting_as(Discretion::OMNIPOTENT_VIEWER, &block)
    end

    private

    def acting_as(as)
      orig_as = Discretion.currently_acting_as
      Discretion.set_currently_acting_as(as)
      yield
    ensure
      Discretion.set_currently_acting_as(orig_as)
    end
  end
end
