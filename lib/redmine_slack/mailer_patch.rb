module RedmineSlack
	module MailerPatch
		def self.included(base) # :nodoc:
			#base.extend(ClassMethods)
			#base.send(:include, InstanceMethods)
			base.send(:prepend, PrependingInstanceMethods)

			#base.class_eval do
			#	unloadable # Send unloadable so it will not be unloaded in development
			#end
		end

		#module ClassMethods
		#end

		#module InstanceMethods
		#end

		module PrependingInstanceMethods
			def reminder(user, issues, days)
				results = Redmine::Hook.call_hook(:redmine_slack_remainder_before_send, { :user => user, :issues => issues, :days => days })
				super(user, issues, days) unless (results.empty? || results.any?{|v| not v})
			end
		end
	end
end
