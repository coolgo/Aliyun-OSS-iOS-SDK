/*
 Copyright 2012 baocai zhang. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE FREEBSD PROJECT ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE FREEBSD PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.
 */
/*
 @author baocai zhang
 website:www.giser.net
 email:zhangbaocaicug@gmail.com
 */

#import "PrimaryKeyType.h"
#import "ColumnType.h"
/**
 ViewMeta 类
 */
@interface ViewMeta : NSObject
{
@private
     NSString *_viewName;
     int _pagingKeyLen;

    NSMutableArray* _resultPrimaryKeys;//List<PrimaryKey> 
    NSMutableDictionary *_primaryKeys;

    NSMutableArray*  _resultAttributeColumns;//List<AttributeColumn>
    NSMutableDictionary *_attributeColumns ;
}
/**
viewName
 */
@property(nonatomic,retain)NSString *viewName;
/**
 pagingKeyLen
 */
@property(nonatomic,assign)int pagingKeyLen;
/**
 primaryKeys
 */
@property(nonatomic,retain,readonly)NSMutableDictionary *primaryKeys;
/**
 attributeColumns
 */
@property(nonatomic,retain,readonly)NSMutableDictionary *attributeColumns;
/**
 初始化方法
 @param viewName NSString
 @param resultPrimaryKeys NSMutableArray
 @param resultAttributeColumns NSMutableArray
 */
-(id) initWithViewName:(NSString*) viewName resultPrimaryKeys:(NSMutableArray*) resultPrimaryKeys  resultAttributeColumns:(NSMutableArray*)resultAttributeColumns;
/**
 addPrimaryKey
 @param key NSString
 @param type PrimaryKeyType
 */
-(void) addPrimaryKey:(NSString*) key  type:(PrimaryKeyType) type;
/**
 addAttributeColumn
 @param column NSString
 @param type ColumnType
 */
-(void) addAttributeColumn:(NSString*) column  type:(ColumnType) type;
@end

