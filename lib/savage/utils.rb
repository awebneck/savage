module Savage
  module Utils
    def bool_to_int(value)
      (value) ? 1 : 0
    end
    def constantize(string)
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ string
        raise NameError, "#{string.inspect} is not a valid constant name!"
      end
      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end
  end
end