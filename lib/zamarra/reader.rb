##
 # The Zamarra module contains a set of utlities for working with Zthes XML
 # documents
 # _____________________________________________________________________________
 #
 # Created by brightSPARK Labs
 # www.brightsparklabs.com
 ##

require 'rexml/document'
require File.expand_path('../model/term', __FILE__)
require File.expand_path('../model/zthes_document', __FILE__)

include Zamarra

module Zamarra

    ##
     # Reads Zthes data and creates models for it
     ##
    class Reader

        # ----------------------------------------------------------------------
        # PUBLIC METHODS
        # ----------------------------------------------------------------------

        ##
         # Reads a Zthes XML file
         #
         # @param xml [String]
         #          path to the XML file to read
         #
         # @return [ZthesDocument] the document created
         ##
        def self.read_zthes_xml(xml)
            xml = File.read(xml)
            document = REXML::Document.new(xml)

            terms = {}
            narrower_terms = []

            document.elements.each('Zthes/term') do |t|

                type = t.elements['termType'].text

                if type == "ND"
                    synonym = t.elements['termName'].text
                    relation = t.elements.to_a('relation').first
                    term_id = relation.elements['termId'].text
                    term = terms[term_id]
                    if term.nil?
                        puts "ERROR: Synonym '#{synonym}' references unknown term_id  #{term_id}"
                    else
                        term.add_synonym synonym
                    end
                end

                # only process 'Preferred Terms'
                next unless type == "PT"

                # create object
                term_id = t.elements['termId'].text
                term_name = t.elements['termName'].text
                term = Model::Term.new term_id, term_name

                # store all children ids
                t.elements.each('relation') do |relation|
                    if relation.elements['relationType'].text == "NT"
                        child_id = relation.elements['termId'].text
                        term.add_child_id child_id
                        narrower_terms << child_id
                    end
                end

                # map id to object
                terms[term_id] = term
            end

            terms.each do |term_id, term|
                term.children_ids.each { |child_id| term.add_child terms[child_id] }
            end

            top_level_terms = terms.reject { |term_id, term| narrower_terms.include? term_id }
            zthes_document = Model::ZthesDocument.new top_level_terms, terms
        end
    end
end
