module RedmineSlack
	module NewsPatch
		def self.included(base) # :nodoc:
			base.extend(ClassMethods)
			base.send(:include, InstanceMethods)

			base.class_eval do
				unloadable # Send unloadable so it will not be unloaded in development
				after_create :create_from_news
				after_update :save_from_news
			end
		end

		module ClassMethods
		end

		module InstanceMethods
			def create_from_news
				Redmine::Hook.call_hook(:redmine_slack_news_new_after_save, { :news => self})
				return true
			end

			def save_from_news
				Redmine::Hook.call_hook(:redmine_slack_news_edit_after_save, { :news => self })
				return true
			end

		end
	end
end
