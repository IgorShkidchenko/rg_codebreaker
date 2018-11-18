# frozen_string_literal: true

String.class_eval do
  def red
    "\e[31m#{self}\e[0m"
  end

  def yellow
    "\e[33m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def blue
    "\e[36m#{self}\e[0m"
  end

  def pink
    "\e[35m#{self}\e[0m"
  end
end
