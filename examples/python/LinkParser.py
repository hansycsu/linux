#!/usr/bin/python3
import requests
import re
from bs4 import BeautifulSoup

class LinkParser:
    links = []
    pics = []

    ######################################################################
    # Search links in target and store in links recursively
    #
    # @param
    #   object self - the instance of this object
    #   string target - the url string of target
    # @return void
    # @author YC Su <hansycsu@gmail.com>
    ######################################################################
    def __init__(self, target):
        self.links.append(target)
        index = 0
        while index < len(self.links):
            print("[{}] {}".format(index, self.links[index]))
            self.getLinks(self.links[index])
            index += 1

    ######################################################################
    # Search <a> links and pictures in url and store in links and pics
    # recursively
    #
    # @param
    #   object self - the instance of this object
    #   string url - the url string
    # @return void
    # @author YC Su <hansycsu@gmail.com>
    ######################################################################
    def getLinks(self, url):
        page = requests.get(url)
        soup = BeautifulSoup(page.text, 'html.parser')
        ###################################################
        # Find all <a> links
        ###################################################
        tagList = soup.find_all('a', href=True)
        for tag in tagList:
            href = tag.get('href')
            if re.match('[^:.]*\.html$', href):
                full_href = self.links[0] + href
                if not full_href in self.links:
                    self.links.append(full_href)
            elif re.match(self.links[0] + '.*' , href):
                if not href in self.links:
                    self.links.append(href)
        ###################################################
        # Find all pictures
        ###################################################
        tagList = soup.find_all('img')
        for tag in tagList:
            src = tag.get('src')
            print("img found: {}".format(src))
            self.pics.append(src)


def main():
    parser = LinkParser('http://downloads.ti.com/processor-sdk-linux/esd/docs/latest/linux/')
    # for url in parser.links:
        # print(url)
    # for pic in parser.pics:
        # print(pic)

if __name__ == "__main__":
    main()
