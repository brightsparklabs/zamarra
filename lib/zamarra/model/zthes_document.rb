##
 # The Zamarra module contains a set of utlities for working with Zthes XML
 # documents
 # _____________________________________________________________________________
 #
 # Created by brightSPARK Labs
 # www.brightsparklabs.com
 ##

module Zamarra
    module Model

        ##
         # Models an XML document
         ##
        class ZthesDocument
            attr_reader :terms, :top_level_terms

            def initialize(top_level_terms, terms)
                @top_level_terms = top_level_terms
                @terms = terms
            end
        end
    end
end
